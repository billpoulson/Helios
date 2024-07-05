import dotenv from 'dotenv'
import { Kafka, Partitioners, logLevel } from 'kafkajs'

// Load environment variables from .env file
dotenv.config();
const kafka = new Kafka({
  clientId: process.env.CLIENT_ID,
  brokers: ['my-kafka.kafka-dev.svc.cluster.local:9092'],
  logLevel: process.env.LOG_LEVEL as unknown as logLevel,
  sasl: {
    mechanism: 'scram-sha-256', // Choose your desired scram mechanism
    username: process.env.KAFKA_CLIENT_USER,
    password: process.env.KAFKA_CLIENT_PASSWORD,
  },
  ssl: false
});
const producer = kafka.producer({
  createPartitioner: Partitioners.LegacyPartitioner,
  allowAutoTopicCreation: true,
});
process.on('SIGINT', async () => {
  console.log('Received SIGINT. Disconnecting producer...');
  await producer.disconnect();
  process.exit(0);
});
process.on('SIGTERM', async () => {
  console.log('Received SIGTERM. Disconnecting producer...');
  await producer.disconnect();
  process.exit(0);
});
process.on('uncaughtException', async (error) => {
  console.error('Uncaught Exception:', error);
  await producer.disconnect();
  process.exit(1);
});
const run = async () => {
  try {
    await producer.connect();
    let i = 0;
    while (true) {
      await new Promise<void>((resolve, reject) => setTimeout(() => resolve(), 1000));
      console.log('tick')
      await producer.send({
        topic: 'aaa1',
        messages: [
          { value: `Hello KafkaJS user! ${i}` },
        ],
      });
      i++;
    }
  } catch (error) {
    console.error('An error occurred:', error);
  } finally {
    await producer.disconnect();
  }
};
run().catch(error => {
  console.error('Failed to execute run:', error);
});
