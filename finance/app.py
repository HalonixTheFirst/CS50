import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    name=db.execute("SELECT username FROM users WHERE id = ?",session["user_id"])[0]["username"]
    cash = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])[0]["cash"]

    stocks=db.execute("""SELECT symbol, SUM(shares) AS total_shares
                        FROM transactions
                        WHERE user_id = ?
                        GROUP BY symbol
                        HAVING total_shares > 0;""",session["user_id"]
                    )
    portfolio=[]
    total_value=cash;
    for stock in stocks:
        quote=lookup(stock["symbol"])
        price=quote["price"]
        shares=stock["total_shares"]
        total=price * shares
        portfolio.append({"symbol":stock["symbol"],"price":price, "shares":shares, "total":total })
        total_value+=total
    return render_template("index.html",name=name,stocks=portfolio,cash=cash,total_value=total_value)


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method=="GET":
        return render_template("buy.html")
    if(request.method=="POST"):
        symbol=request.form.get("symbol")
        try:
            shares=int(request.form.get("shares"))
            if shares<=0:
                return apology("Shares must be more than zero")
        except ValueError:
            return apology("Not Valid Value")
        data=lookup(symbol)
        if data is None:
            return apology("Not Valid Value")
        price=data["price"]*shares
        balance=db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])
        if price > balance[0]["cash"] :
            return apology("Not Enough cash")
        db.execute("UPDATE users SET cash=cash-? WHERE id = ?",price,session["user_id"])
        db.execute("INSERT INTO transactions (user_id,symbol,shares,price) VALUES(?,?,?,?)",session["user_id"],data["symbol"],shares,data["price"])

        return redirect("/")


@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    transactions=db.execute("SELECT * FROM transactions WHERE user_id=?",session["user_id"])
    return render_template("history.html",transactions=transactions)
    return apology("TODO")


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute(
            "SELECT * FROM users WHERE username = ?", request.form.get("username")
        )

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(
            rows[0]["hash"], request.form.get("password")
        ):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    if request.method=="GET":
        return render_template("quote.html")
    if request.method=="POST":
        symbol=request.form.get("symbol")
        data=lookup(symbol)
        if data is None:
            return apology("Data returned none")
        return render_template("quoted.html",data=data)


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""
    if request.method=="POST":
        name=request.form.get("username")
        if not name:
            return apology("Enter a name lil bro",400)
        # try:
        #     db.execute("SELECT * FROM users WHERE name= ?",name)
        # except ValueError:
        #     return apology("Name already registered",400)
        password=request.form.get("password")
        confirm_password=request.form.get("confirmation")
        if not password or not confirm_password:
            return apology("Enter passwords lil bro",400)
        if password !=confirm_password:
            return apology("Passwords Don't match bro",400)
        pw_hash=generate_password_hash(password, method='scrypt', salt_length=16)
        try:
            db.execute("INSERT INTO users (username,hash) VALUES(?,?)",name,pw_hash)
        except ValueError:
            return apology("User Already Exists")
        return redirect("/login")
    else:
        return render_template("register.html")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    if request.method=="GET" :
        symbols=db.execute("SELECT symbol FROM transactions WHERE user_id = ? GROUP BY symbol HAVING SUM(shares) > 0",session["user_id"])
        return render_template("sell.html",symbols=symbols)
    if request.method=="POST":
        symbol= request.form.get("symbol")
        shares= int(request.form.get("shares"))
        data=lookup(symbol)
        if data is None:
            return apology("Not valid symbol")
        if shares<=0 :
            return apology("Shares must be positive")
        holding = db.execute("SELECT SUM(shares) AS total_shares FROM transactions WHERE user_id=? AND symbol=?",session["user_id"], symbol)[0]["total_shares"]
        if holding is None or shares>holding:
            return apology("You do not have enough shares")
        revenue=data["price"]*shares
        db.execute("UPDATE users SET cash=cash+? WHERE id=?",revenue,session["user_id"])
        db.execute("INSERT INTO transactions (user_id,symbol,shares,price) VALUES(?,?,?,?)",session["user_id"],data["symbol"],-shares,data["price"])
        return redirect("/")

@app.route("/deposit",methods=["GET","POST"])
@login_required
def deposit():
    if request.method=="GET":
        return render_template("deposit.html")
    if(request.method=="POST"):
        depositAmount=int(request.form.get("depAmount"))
        if depositAmount>0 :
            db.execute("UPDATE users SET cash=cash+? WHERE id =?",depositAmount,session["user_id"])
            return redirect("/")
        else:
            return apology("Invalid Input")
