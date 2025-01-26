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

# Consumer configuration
consumer_config = {
    'bootstrap_servers': 'localhost:9092',
    'group_id': 'my-group',
    'auto_offset_reset': 'earliest',
    'security_protocol': 'SSL',
    'ssl_context': ssl_context  # Assuming ssl_context is defined as in the producer snippet
}

# Create consumer
consumer = KafkaConsumer('my-topic', **consumer_config)

# Consume messages
for message in consumer:
    print(f"Received message: {message.value.decode()}")

# Close consumer
consumer.close()