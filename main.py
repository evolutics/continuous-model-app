import flask
import markupsafe

app = flask.Flask(__name__)


@app.route("/")
def go():
    return _render_status(is_ok=True, details="…")


def _render_status(*, is_ok, details):
    heading = (
        '<h1 style="color: green">OK</h1>'
        if is_ok
        else '<h1 style="color: red">NOK</h1>'
    )
    return f"""<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Status</title>
  </head>
  <body>
    {heading}
    <pre>{markupsafe.escape(details)}</pre>
  </body>
</html>
"""
