type Recipe = {
  id: string;
  title: string;
  labelsId: string[];
  images?: { value: string }[];
  calories?: number;
  ingredients?: string;
  instructions?: string;
  prepTime?: number;
};
