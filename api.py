from fastapi import FastAPI
from backend.rag import rag_agent
from backend.data_models import Prompt

app = FastAPI()

@app.post("/chatbot/query")
async def ask_botagent(query: Prompt):
    result = await rag_agent.run(query.prompt)
    
    return result.output