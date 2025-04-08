import subprocess
import threading
from flask import Flask, request, jsonify

app = Flask(__name__)

def run_kometa(libraries):
    """
    Launches Kometa using the provided libraries parameter.
    The command executed is:
        python3 /kometa.py ----run-libraries <libraries>
    """
    # Run Kometa in a subprocess and wait for it to finish (or simply let it run)
    process = subprocess.Popen(["python3", "/kometa.py", "--run-libraries", libraries])
    process.wait()

@app.route('/kometa', methods=['POST'])
def kometa():
    data = request.get_json()
    # Check if the "libraries" parameter is provided in the JSON payload
    libraries = data.get("libraries")
    if not libraries:
        return jsonify({"error": "Missing 'libraries' parameter"}), 400

    try:
        # Launch Kometa in a new thread so that the API can return immediately
        thread = threading.Thread(target=run_kometa, args=(libraries,))
        thread.start()
        return jsonify({"status": "Kometa started with libraries parameter", "libraries": libraries}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    # Run the Flask API on port 5000
    app.run(host='0.0.0.0', port=5000)
