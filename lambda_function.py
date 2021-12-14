
import subprocess

def lambda_handler(event, context):

    r = subprocess.run(["poetry", "run", "myapp", event["url"]], capture_output=True)
    
    return {
        "exit_code": r.returncode,
        "stdout": r.stdout,
        "stderr": r.stderr
    }
