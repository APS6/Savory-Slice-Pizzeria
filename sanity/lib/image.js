import createImageUrlBuilder from "@sanity/image-url";
import { dataset, projectId } from "../env";

const imageBuilder = createImageUrlBuilder({
  projectId: projectId || "",
  dataset: dataset || "",
});

export const urlForImage = (source) => {
  try {
    const imageUrl = imageBuilder?.image(source).auto('format').fit('max').url();
    return imageUrl ? { src: imageUrl, height: 300, width: 400 } : null;
  } catch (error) {
    console.log(error)
  }
};
