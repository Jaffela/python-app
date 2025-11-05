from flask import Flask, jsonify, request

app = Flask(__name__)

tasks = [
    {"id": 1, "title": "Do homework"},
    {"id": 2, "title": "Write report"},
]


@app.route("/tasks", methods=["GET"])
def get_tasks():
    return jsonify(tasks)


@app.route("/tasks", methods=["POST"])
def add_task():
    data = request.get_json()
    new_task = {
        "id": len(tasks) + 1,
        "title": data.get("title", "")
    }
    tasks.append(new_task)
    return jsonify(new_task), 201


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
