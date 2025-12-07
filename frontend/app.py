      
import streamlit as st
import requests
from pathlib import Path

def layout():

    st.markdown("# AIengineering chatbot")
    st.markdown("Ask anything related to Data engineering")
    text_input = st.text_input(label="Ask a questions")

    if st.button("Send") and text_input != "":
        response = requests.post(
           "http://127.0.0.1:8000/chatbot/query", json={"prompt": text_input}
        )

        data = response.json()

        st.markdown("## Question:")
        st.markdown(text_input)

        st.markdown("## Answer:")
        st.markdown(data["answer"])

        st.markdown("## Source:")
        st.markdown(data["filepath"])
 

if __name__ == "__main__":
    layout()