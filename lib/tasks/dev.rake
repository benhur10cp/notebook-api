namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    puts 'Resetando o BD'
    #%x(rails db:drop db:create db:migrate)
    puts 'BD resetado'

    puts 'Cadastrando os tipos de contatos...'

    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
          description: kind
      )
    end

    puts 'Tipos de contatos cadastrados!'

    ##################################################################################

    puts 'Cadastrando contatos...'
    100.times do |i|
      Contact.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          birthdate: Faker::Date.between(65.year.ago, 18.year.ago),
          kind: Kind.all.sample
      )
    end
    puts 'Contatos cadastrados!'

    ##################################################################################

    puts 'Cadastrando telefones'
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end
    puts 'Telefones cadastrados'

    ##################################################################################
    puts 'Cadastrando endereços'
    Contact.all.each do |contact|
      Address.create(
                          street: Faker::Address.street_address,
                          city: Faker::Address.city,
                          contact: contact
      )
    end
    puts 'Endereços cadastrados'
  end

end
