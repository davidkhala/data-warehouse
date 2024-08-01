# From GCP Pub/Sub
https://docs.gcp.databricks.com/en/connect/streaming/pub-sub.html?_ga=2.4753649.392220655.1722503747-90946192.1722503745#subscribe-to-google-pubsub


## Drawback
- Pub/Sub might publish duplicate records, and records might arrive to the subscriber out of order.
  - Solution: You should write Databricks code to handle duplicate and out-of-order records.
