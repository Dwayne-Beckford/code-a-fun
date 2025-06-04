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
dave = User.create(email:"dave@test.com", password: "123456", name: "Dave")
jane = User.create(email:"jane@test.com", password: "123456", name: "Jane", points: 10)

puts "Creating Level Basics"
level_one = Level.create(number: 1, name: "Basics")

puts "Creating Lesson 1"
lesson_one = Lesson.create(name: "Arrays pt1", number: "1", concept: "An array is a way of organizing data in a collection, where each item (called an element) has a specific position or index. Think of it as a row of numbered boxes where you can store values. In programming, arrays are often used to store multiple values of the same type, making it easier to access and manipulate them.", description: "In this lesson you'll learn everything about arrays: what they are, how to write them and more.", task: "Create an array with fruit", level: level_one)

puts "Creating Lesson 2"
lesson_two = Lesson.create(name: "Arrays pt2", number: "2", concept: "An array is a way of organizing data in a collection, where each item (called an element) has a specific position or index. Think of it as a row of numbered boxes where you can store values. In programming, arrays are often used to store multiple values of the same type, making it easier to access and manipulate them.", description: "In this lesson you'll learn everything about arrays: what they are, how to write them and more.", task: "Create an array with fruit", level: level_one)

puts "Creating Lesson 3"
lesson_three = Lesson.create(name: "Loops", number: "3", concept: "In programming, a loop is a control flow statement that allows a section of code to be executed repeatedly until a specific condition is met or until a certain number of iterations have been completed. Loops are essential for performing repetitive tasks efficiently and can significantly improve program efficiency by reducing redundancy and simplifying complex processes.", description: "In this lesson you'll learn everything about loops: what they are, how to write them and more.", task: "Create a loop for a countdown", level: level_one)

puts "Creating user levels"
daves_last_level = UserLevel.create(completed: false, user: dave, level: level_one)
janes_last_level = UserLevel.create(completed: false, user: jane, level: level_one)

puts "Creating user lessons"
daves_last_lesson = UserLesson.create(completed: true, user: dave, lesson: lesson_one)
janes_last_lesson = UserLesson.create(completed: true, user: jane, lesson: lesson_two)

puts "Creating Jane's achievements"
janes_achievement = Achievement.create(user: jane, name: "Gold Medal")

# Done!
puts "All done! Created #{User.count} users, #{Lesson.count} lessons, #{Level.count} levels, #{Achievement.count} achievements and #{UserLesson.count} progresses (user lessons)"
