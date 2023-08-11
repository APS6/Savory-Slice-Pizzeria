import Stripe from 'stripe';
import { NextResponse } from 'next/server';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY);

export default async function POST(req, res) {
  const body = await req.json()
    try {
      const params = {
        submit_type: 'pay',
        mode: 'payment',
        payment_method_types: ['card'],
        billing_address_collection: 'auto',
        line_items: body.map((item) => {
          return {
            price_data: { 
              currency: 'usd',
              product_data: { 
                name: item.name,
              },
              unit_amount: item.tprice * 100,
            },
            adjustable_quantity: {
              enabled:true,
              minimum: 1,
            },
            quantity: item.quantity
          }
        }),
        success_url: `/Order`,
        cancel_url: `/Cart`,
      }

      // Create Checkout Sessions from body params.
      const session = await stripe.checkout.sessions.create(params);

     return NextResponse.json(session, {success: true}, { status: 200 });
    } catch (err) {
      return NextResponse.json({ error: 'Failed payment', success: false }, { status: 400 });
    }
}