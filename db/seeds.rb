# frozen_string_literal: true

def green(string)
  puts "\033[0;32m#{string}\033[0m"
end

def red(string)
  puts "\033[31m#{string}\033[0m"
end

puts "\nCleaning previous records"

MODELS = [
  Quiz,
  User
].freeze

MODELS.each do |model|
  begin
    model.destroy_all
    green "Clean records of #{model} -> ✔ Success"
  rescue
    red "Clean records of #{model} -> ✖ Error"
  end
end

puts "\nCreating users\n"

users = User.create([
  {
    name: 'SUCEN',
    email: 'sucen@email.com',
    password: '*****'
  },
  {
    name: 'Instituto de Educação',
    email: 'inst_educa@email.com',
    password: '*****'
  }
])

puts "\nCreating quizzes\n"

quizzes = Quiz.create([
  {
    user: users[1],
    title: 'COVID-19',
    code: 'XPWJ',
    questions: [
      {
        id: 1,
        text: 'A COVID-19 é uma doença...',
        alternatives: [
          {
            id: 1,
            text: 'Congenita'
          },
          {
            id: 2,
            text: 'Infecciosa'
          },
          {
            id: 3,
            text: 'Do sistema nervoso'
          },
          {
            id: 4,
            text: 'Endócrina'
          }
        ]
      },
      {
        id: 2,
        text: 'Qual desses não é sintoma da COVID-19?',
        alternatives: [
          {
            id: 1,
            text: 'Febre'
          },
          {
            id: 2,
            text: 'Tosse seca'
          },
          {
            id: 3,
            text: 'Cegueira'
          },
          {
            id: 4,
            text: 'Cansaço'
          }
        ]
      },
      {
        id: 3,
        text: 'Qual dessas não é considerada uma boa prática durante a pandemia?',
        alternatives: [
          {
            id: 1,
            text: 'Manter hábitos de higiene'
          },
          {
            id: 2,
            text: 'Isolamento'
          },
          {
            id: 3,
            text: 'Sair sem máscara'
          },
          {
            id: 4,
            text: 'Manter distância de pessoas espirrando'
          }
        ]
      }
    ]
  }
])

