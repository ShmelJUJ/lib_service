import uvicorn
import os

from dotenv import load_dotenv

from app import create_app
from app.bd import connection

if __name__ == "__main__":
    uvicorn.run("main:app", port=int(os.getenv("PORT", 5000)), log_level="info", reload=True, reload_dirs=["app"])
else:
    app = create_app()
    cur = connection()