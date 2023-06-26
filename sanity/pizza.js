export default {
  name: "pizza",
  type: "document",
  title: "Pizza",
  fields: [
    {
      name: "name",
      type: "string",
      title: "Name",
    },
    {
      name: "ingredients",
      title: "Ingredients",
      type: "string",
    },
    {
      name: "price",
      type: "string",
      title: "Price",
    },
    {
      name: "image",
      title: "Image",
      type: "image",
      options: {
        hotspot: true,
      },
    },
    {
      name: "slug",
      title: "Slug",
      type: "slug",
      options: {
        source: "name",
      },
    },
    {
      name: 'category',
      title: 'Category',
      type: 'string',
    }
  ],
};
