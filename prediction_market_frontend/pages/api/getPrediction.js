import OpenAI from 'openai';

const configuration = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY,
  });

export default async function handler(req, res) {
    const { eventInfo } = req.body;

    try {
        const response = await configuration.chat.completions.create({
            model: "gpt-3.5-turbo",
            messages: [{ role: 'user', content: `Provide a detailed prediction based on the following event: ${eventInfo}`}],
            max_tokens: 100,
        });

        const prediction = response.data.choices[0].delta.content.trim();
        res.status(200).json({ prediction });
    } catch (error) {
        res.status(500).json({ error: "Failed to get prediction" });
    }
}
