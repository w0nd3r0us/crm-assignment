require_relative 'contact'
require 'pry'

class CRM < Contact

  def initialize(name)
    @name = name
   puts "Okay, this CRM has the name " + @name
  end

  def main_menu
    while true # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(selection)
    case selection
    when 1
      add_new_contact
    when 2
      modify_existing_contact
    when 3
      delete_contact
    when 4
      display_all_contacts
    when 5
      search_by_attribute
    when 6
      exit

    end
  end

  def add_new_contact
    # ask first name
    puts 'Enter contacts First name:'
    first_name = gets.chomp
    # ask second name
    puts 'Enter contacts Last name:'
    last_name = gets.chomp
    # ask email
    puts 'Enter contacts email address:'
    email = gets.chomp
    # option note
    puts 'Would you like to leave a note?:'
    note = gets.chomp
    contact = Contact.create(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      note:       note
      )
  end

  def modify_existing_contact
    puts "\n---Modify Contact---"
    puts "Enter ID of the contact you'd like to modify:"
    user_input = gets.to_i
    user_edit = Contact.find(user_input)
    puts "Which value do you wish to update?"
    puts "1: First name\n2: Last name\n3. Email\n4. Notes"
    user_choice = gets.to_i
    case user_choice
    when 1
      puts "Enter new First name"
      new_val = gets.chomp
      # binding.pry
      user_edit.update(:first_name => new_val)
    when 2
      puts "Enter new Last name"
      new_val = gets.chomp
      user_edit.update(:last_name => new_val)
    when 3
      puts "Enter new Email"
      new_val = gets.chomp
      user_edit.update(:email => new_val)
    when 4
      puts "Enter new note"
      new_val = gets.chomp
      user_edit.update(:note => new_val)
    end

  end

  def delete_contact
    puts "Enter ID of contact you wish to delete:"
    id_value = gets.to_i
    delete_value = Contact.find(id_value)
    puts "Do you wish to delete #{delete_value}? y/n?"
    answer = gets.chomp.downcase
      if answer == 'y'
        delete_value.delete
      # binding.pry
      end
  end

  def display_all_contacts
    puts "----CONTACT LIST----"
    puts Contact.each
  end

  def search_by_attribute
    print "enter the attribute (first_name, last_name, email, note)"
    user_attr = gets.chomp.downcase
    puts "enter the value"
    user_value = gets.chomp.downcase
    puts Contact.find_by(user_attr => user_value)
  end

  # def show_contact(contact)
  #   puts "#{contact.full_name.split.map(&:capitalize).join(' ')} | email:#{contact.email} | notes:#{contact.note}"
  # end
end


at_exit do
  ActiveRecord::Base.connection.close
end
runapp = CRM.new('runapp')

binding.pry
