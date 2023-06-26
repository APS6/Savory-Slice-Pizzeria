import React from 'react'
import Pizza from './pizza';
const Category = (props) => {

   const categories = props.categories;
    const pizzas = props.pizzas;
  return (
    <>
    {categories.map((category) => (
        <div key={category.id} className='pb-32'>
          <h2 className='text-3xl md:text-5xl text-col2 pb-8'>{category.name}</h2>
          <div className="grid gap-8 grid-cols-1 sm:grid-cols-2 md:grid-cols-3 w-full">
        <Pizza pizzas={pizzas} catslug={category.slug.current}/>
      </div>
        </div>
      ))}
      </>
  )
}

export default Category