import flask
import http
import markupsafe
import psycopg

app = flask.Flask(__name__)


@app.route("/")
def go():
    try:
        with psycopg.connect(
            "dbname=postgres host=db password=mysecretpassword user=postgres"
        ) as connection, connection.cursor() as cursor:
            cursor.execute(
                """CREATE TABLE IF NOT EXISTS visit (
                    visited_at timestamp DEFAULT current_timestamp)"""
            )

            cursor.execute("INSERT INTO visit DEFAULT VALUES")
            counts = cursor.execute("SELECT count(*) FROM visit").fetchone()[0]

            return _render_status(is_ok=True, details=f"This is visit #{counts}.")
    except Exception as exception:
        return (
            _render_status(is_ok=False, details=str(exception)),
            http.HTTPStatus.INTERNAL_SERVER_ERROR,
        )


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
