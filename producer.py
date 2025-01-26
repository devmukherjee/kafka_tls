from kafka import KafkaProducer
from kafka.errors import KafkaError
import ssl

# Configuration parameters
keystore_location = "path/to/client.keystore"
keystore_password = "your_keystore_password"
truststore_location = "path/to/truststore.jks"
truststore_password = "your_truststore_password"

# Configure SSL context
ssl_context = ssl.create_default_context(purpose=ssl.Purpose.CLIENT_AUTH)
ssl_context.load_cert_chain(keystore_location, keystore_password)
ssl_context.load_verify_locations(truststore_location)

# Producer configuration
producer_config = {
    'bootstrap_servers': 'localhost:9092',
    'security_protocol': 'SSL',
    'ssl_context': ssl_context
}

# Create producer
producer = KafkaProducer(**producer_config)

# Send message
try:
    producer.send('my-topic', b'Hello, world!')
    producer.flush()
except KafkaError as e:
    print(f"Failed to send message: {e}")

# Close producer
producer.close()