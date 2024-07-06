import dotenv from 'dotenv'
import { Kafka, Partitioners, logLevel } from 'kafkajs'

// Load environment variables from .env file
dotenv.config();
const kafka = new Kafka({
  clientId: `${process.env.CLIENT_ID}-${+new Date()}`,
  brokers: [process.env.BROKER],
  logLevel: process.env.LOG_LEVEL as unknown as logLevel,
  sasl: {
    mechanism: 'plain', // Choose your desired scram mechanism
    username: process.env.KAFKA_CLIENT_USER,
    password: process.env.KAFKA_CLIENT_PASSWORD,
  },
  ssl: false
});
const producer = kafka.producer({
  createPartitioner: Partitioners.DefaultPartitioner,
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
        topic: 'bx',
        messages: [
          { value: `bx - Hello KafkaJS user! ${i}` },
        ],
      });
      await producer.send({
        topic: 'b',
        messages: [
          { value: `b - Hello KafkaJS user! ${i}` },
        ],
      });
      await producer.send({
        topic: 'topic-a',
        messages: [
          { value: `topic-a - Hello KafkaJS user! ${i}` },
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
