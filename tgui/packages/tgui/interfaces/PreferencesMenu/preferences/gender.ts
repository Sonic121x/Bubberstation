export enum Gender {
  Male = 'male',
  Female = 'female',
  Other = 'plural',
  Other2 = 'neuter',
}

export const GENDERS = {
  [Gender.Male]: {
    icon: 'mars',
    text: '他（He/Him）',
  },

  [Gender.Female]: {
    icon: 'venus',
    text: '她（She/Her）',
  },

  [Gender.Other]: {
    icon: 'transgender',
    text: 'TA（They/Them）',
  },

  [Gender.Other2]: {
    icon: 'neuter',
    text: '它（It/Its）',
  },
};
