from flask import Flask, render_template, request, redirect, url_for
import os

app = Flask(__name__)

# CONFIGURATION
# In a complex setup, we could store secrets here.
app.config['SECRET_KEY'] = 'dev-key-change-this-in-prod'

@app.route('/')
def home():
    """
    The Landing Page. 
    Shows a 'Connect' button and system status overview.
    """
    return render_template('index.html')

@app.route('/console')
def console():
    """
    The Main Dashboard.
    This serves the page that embeds the TTYD terminal.
    """
    # We pass the backend port to the template so it knows where to connect
    return render_template('dashboard.html', backend_port=7681)

@app.route('/logout')
def logout():
    """
    Simple redirect back to home to simulate a disconnect.
    """
    return redirect(url_for('home'))

if __name__ == '__main__':
    # Dev mode execution (Docker uses Gunicorn, but this is good for local testing)
    app.run(host='0.0.0.0', port=5000, debug=True)
