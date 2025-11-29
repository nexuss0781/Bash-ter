import os
from flask import Flask, render_template, redirect, url_for
from dotenv import load_dotenv

# Load variables from .env file (if running locally without docker)
load_dotenv()

app = Flask(__name__)

# Config
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev-default-key')

# Get the Backend URL from Docker Environment or .env file
# This is crucial: The BROWSER needs to know where to connect.
BACKEND_URL = os.environ.get('BACKEND_URL', 'http://localhost:7681')

@app.route('/')
def home():
    """Landing Page"""
    return render_template('index.html')

@app.route('/console')
def console():
    """
    Main Dashboard.
    We pass the BACKEND_URL to the HTML so the iframe knows where to point.
    """
    return render_template('dashboard.html', backend_url=BACKEND_URL)

@app.route('/logout')
def logout():
    return redirect(url_for('home'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
