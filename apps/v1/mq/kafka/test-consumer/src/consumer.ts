import { Kafka, logLevel } from 'kafkajs'

// Configuration constants, can be adjusted based on environment
const clientId = 'my-producer';
const brokers = ['my-kafka.kafka-dev.svc.cluster.local:9092'];
const groupId = 'test-group';
const topic = 'test-topic';

// Create a Kafka instance with specified configuration
const kafka = new Kafka({
  clientId,
  brokers,
  logLevel: logLevel.INFO, // Set log level to get more detailed logs
});

// Create a consumer instance
const consumer = kafka.consumer({ groupId });

const run = async () => {
  try {
    await consumer.connect();
    console.log('Consumer connected');
    await consumer.subscribe({ topic, fromBeginning: true });
    console.log(`Subscribed to topic: ${topic}`);

    await consumer.run({
      eachMessage: async ({ topic, partition, message }) => {
        console.log({
          partition,
          offset: message.offset,
          value: message.value?.toString(),
        });
      },
    });
  } catch (error) {
    console.error('Error in Kafka consumer:', error);
    process.exit(1); // Exit with failure code
  }
};

run().catch(error => {
  console.error('Error in Kafka consumer run:', error);
  process.exit(1); // Exit with failure code
});
