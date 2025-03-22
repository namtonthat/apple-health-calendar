import streamlit as st

st.set_page_config(page_title="Welcome", layout="wide")
st.title("🏠 Welcome to Your Health Dashboard")

st.markdown("Choose a dashboard:")

col1, col2, col3, col4 = st.columns(4)
with col1:
    if st.button("🏋️ Exercises"):
        st.switch_page("pages/1_Exercises.py")
with col2:
    if st.button("😴 Sleep"):
        st.switch_page("pages/2_Sleep.py")
with col3:
    if st.button("🍽️ Nutrition"):
        st.switch_page("pages/3_Nutrition.py")
with col4:
    if st.button("🧠 Mental Health"):
        st.switch_page("pages/4_Mental_Health.py")
