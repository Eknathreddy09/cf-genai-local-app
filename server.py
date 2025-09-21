import requests
from flask import Flask, render_template, request, jsonify

OLLAMA_BASE_URL = "http://localhost:11434/v1"
OLLAMA_MODEL = "llama3.2:1b"

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        prompt = request.form["prompt"]
        response = ask_ollama(prompt)
        return render_template("chat.html", prompt=prompt, response=response)
    return render_template("chat.html")

@app.route("/api/chat", methods=["POST"])
def api_chat():
    data = request.json
    prompt = data.get("prompt", "")
    response = ask_ollama(prompt)
    return jsonify({"response": response})

def ask_ollama(prompt):
    try:
        payload = {
            "model": OLLAMA_MODEL,
            "messages": [
                {"role": "system", "content": "You are a helpful assistant."},
                {"role": "user", "content": prompt}
            ]
        }
        resp = requests.post(f"{OLLAMA_BASE_URL}/chat/completions", json=payload, timeout=360)
        resp.raise_for_status()
        return resp.json()["choices"][0]["message"]["content"]
    except Exception as e:
        return f"Error: {e}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
