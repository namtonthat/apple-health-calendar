## Apple Health Calendar
Simple python script that automates the conversion of past daily statistics from Apple Watch into a calendar event.

```mermaid
graph TD
    A[fa:fa-mobile iPhone / Apple Watch] -->|Auto Health Export|B
    A[fa:fa-mobile iPhone / Apple Watch] -->|Autosleep|B
    B[apple-health.py] --> C[fa:fa-aws AWS Lambda]
    C --> D[AWS S3 Bucket as .ics]
```