import subprocess
import threading

from flask import Flask, jsonify

app = Flask(__name__)


def run_kometa():
    process = subprocess.Popen(["python3", "kometa.py", "--run"])
    process.wait()


@app.route('/kometa', methods=['POST'])
def trigger():
    # Start Kometa in a separate thread
    thread = threading.Thread(target=run_kometa)
    thread.start()
    return jsonify({"status": "Start Kometa in background."}), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
