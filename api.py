from fastapi import FastAPI
from backend.rag import rag_agent, RagResponse
from backend.data_models import Prompt

app = FastAPI()

last_result = None   

@app.post("/chatbot/query", response_model=RagResponse)
async def ask_botagent(query: Prompt):
    global last_result
    #stores memory
    message_history = last_result.all_messages() if last_result else None

    result = await rag_agent.run(
        query.prompt,
        message_history=message_history,
    )

    last_result = result
    return result.output