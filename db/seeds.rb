# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 1. Clean the database
puts "Cleaning database..."

Achievement.destroy_all
UserLesson.destroy_all
UserLevel.destroy_all
Lesson.destroy_all
Level.destroy_all
User.destroy_all

# 2. Creating

puts "Creating user Dave"
dave = User.create(email:"dave@test.com", password: "123456", name: "Dave", points: 50)
jane = User.create(email:"jane@test.com", password: "123456", name: "Jane", points: 30)
larry = User.create(email:"larry@test.com", password: "123456", name: "Larry", points: 0)

puts "Creating Level Basics"
level_one = Level.create(number: 1, name: "Game 1")
level_two = Level.create(number: 2, name: "Game 2")

puts "Creating Lesson 1"

lesson_one = Lesson.create!(name: "Output & Variables", number: 1, concept: "Let’s break it down:

puts — This tells Ruby to say something. It prints to the screen.

Variables — Think of these as little boxes where Ruby can store information. You can name your box (like name or age) and fill it with stuff (like 'Alex' or 27).

📦 Example: name = 'Alex'
puts 'Hello, \#{name}!',

🧪 What’s happening? We store 'Alex' in the box called name. Then we ask Ruby to say 'Hello, Alex!' by using \#{name} — that’s called string interpolation (fancy term, easy trick).",

description: "Let’s talk to your computer! In this lesson, you’ll learn how to make Ruby say things and remember stuff using variables. It’s like giving your computer a brain… and a voice.",
task: "Mission: Make Ruby Your Hype Buddy

Write a short Ruby program that:

Stores your name in a variable.

Stores your favorite snack in another variable.

Uses puts to print a fun message like:  Hey Sam! Let's grab some popcorn and code together! 🚀

💬 Use your own name and snack. Make it YOU.", answer: "'name = 'Ruby'
snack = 'donuts'
puts my buddy name is \#{name} and I like \#{snack}, level: level_one')",
level: level_one
)

puts "Creating Lesson 2 in Level 2"

lesson_two = Lesson.create(name: "Classes", number: 2, concept: "In object-oriented programming, a class defines the shared aspects of objects created from the class. The capabilities of a class differ between programming languages, but generally the shared aspects consist of state (variables) and behavior (methods) that are each either associated with a particular object or with all objects of that class.", description: "In this lesson you'll learn everything about classes: what they are, how to write them and more.", task: "Create a class for animals", answer: "rails g" , level: level_two)

puts "Creating Lesson 3"
lesson_three = Lesson.create(name: "Conditional Logic", number: 3, concept: "Conditional logic, also known as conditional statements or conditionals, is a fundamental programming concept that allows a program to make decisions and execute different code blocks based on whether specific conditions are true or false. This enables programs to adapt to user input and varying situations, providing more complex and flexible functionality.", description: "In this lesson you'll learn everything about if statements: what they are, how to write them and more.", task: "Create an if for an voting age checker", answer: 'if age > 18 puts you cant vote', level: level_two)

puts "Creating Lesson 4"
lesson_four = Lesson.create(name: "Database", number: 4, concept: "Database programming involves using specific languages and techniques to interact with and manage databases, enabling them to store, retrieve, and manipulate data. It's crucial for various applications, from self-driving cars to package tracking systems.", description: "In this lesson you'll learn everything about db: what they are, how to write them and more.", task: "Create a db for a hospitals", answer: "rails g",  level: level_two)

puts "Creating Lesson 5"
lesson_five = Lesson.create(name: "Hashes", number: 5, concept: "Hashing in programming involves using a mathematical algorithm (a hash function) to convert data into a fixed-length value, often called a hash code or hash value. This process is used in various applications, including data storage and retrieval, security measures like password storage, and digital signatures.", description: "In this lesson you'll learn everything about hashes: what they are, how to write them and more.", task: "Create a hash for movies", answer: 'eaxmple = {"key"=> "value"}', level: level_two)

puts "Creating Lesson 6"
lesson_six = Lesson.create(name: "Loops", number: 6, concept: "In programming, a loop is a control flow statement that allows a section of code to be executed repeatedly until a specific condition is met or until a certain number of iterations have been completed. Loops are essential for performing repetitive tasks efficiently and can significantly improve program efficiency by reducing redundancy and simplifying complex processes.", description: "In this lesson you'll learn everything about loops: what they are, how to write them and more.", answer: "while", task: "Create a loop for a countdown", level: level_two)

puts "Creating user levels"
daves_last_level = UserLevel.create(completed: false, user: dave, level: level_one)
janes_last_level = UserLevel.create(completed: false, user: jane, level: level_one)

puts "Creating Dave's progress"
# Marks multiple lessons as complete (from 1 to 5)
[lesson_one, lesson_two, lesson_three, lesson_four, lesson_five].each do |lesson|
  UserLesson.create(completed: true, user: dave, lesson: lesson)
end

puts "Creating Jane's progress"
[lesson_one, lesson_two, lesson_three, lesson_four].each do |lesson|
  UserLesson.create(completed: true, user: jane, lesson: lesson)
end

puts "Creating Dave's achievements"
daves_achievement = Achievement.create(user: dave, name: "Gold Medal")

puts "Creating Jane's achievements"
janes_achievement = Achievement.create(user: jane, name: "Silver Medal")

# Done!
puts "All done! Created #{User.count} users, #{Lesson.count} lessons, #{Level.count} levels, #{Achievement.count} achievements and #{UserLesson.count} progresses (user lessons)"
