from flask import Flask
import logging

# https://github.com/NaturalHistoryMuseum/pyzbar/
# https://github.com/mchehab/zbar

app = Flask(__name__)

@app.route("/")
def hello_world():
    try:
        from pyzbar.pyzbar import decode
        from PIL import Image
        if decode(Image.open('./code128.png')):
            return "decoded"
        else:
            return "not decoded"
    except Exception as e:
        logging.error(e)
        print(e)

    return "<p>Hello, World!</p>"

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)