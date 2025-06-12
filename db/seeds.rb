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

puts "Creating users"
diana = User.create(email:"diana@test.com", password: "123456", name: "Diana", points: 0)
david = User.create(email:"david@test.com", password: "123456", name: "David", points: 100)

puts "Creating Level 1"
file = File.open("app/assets/images/l-1.gif")
level_one = Level.create(number: 1, name: "The Basics")
level_one.photo.attach(io: file, filename: "l-1.gif", content_type: "image/gif")
level_one.save!

puts "Creating Level 2"
file = File.open("app/assets/images/game-1.gif")
level_two = Level.create(number: 2, name: "Directions Master")
level_two.photo.attach(io: file, filename: "game-1.gif", content_type: "image/gif")
level_two.save!

puts "Creating Level 3"
file = File.open("app/assets/images/game-2.gif")
level_three = Level.create(number: 3, name: "Whack-a-Dot")
level_three.photo.attach(io: file, filename: "game-2.gif", content_type: "image/gif")
level_three.save!

puts "Creating Level 4"
file = File.open("app/assets/images/game-3.gif")
level_four = Level.create(number: 4, name: "Gold Rush")
level_four.photo.attach(io: file, filename: "game-3.gif", content_type: "image/gif")
level_four.save!

puts "Creating Level 5"
file = File.open("app/assets/images/game-4.gif")
level_four = Level.create(number: 5, name: "Snake")
level_four.photo.attach(io: file, filename: "game-4.gif", content_type: "image/gif")
level_four.save!

puts "Creating Level 6"
file = File.open("app/assets/images/game-5.gif")
level_four = Level.create(number: 6, name: "Dodge the Meteor")
level_four.photo.attach(io: file, filename: "game-5.gif", content_type: "image/gif")
level_four.save!

puts "Creating Level 7"
file = File.open("app/assets/images/game-6.gif")
level_four = Level.create(number: 7, name: "Mega Challenge")
level_four.photo.attach(io: file, filename: "game-6.gif", content_type: "image/gif")
level_four.save!

puts "Creating Lesson 1 in Level 1"
file = File.open("app/assets/images/seed/1.png")
lesson_one = Lesson.create!(
  name: "Say Hello",
  number: 1,
  level: level_one,
  description: "Your code’s first words! Let’s make Ruby speak — and not just mumble.",
  concept: <<~CONCEPT,
    <p>In Ruby, the command <code>puts</code> makes your program <strong>say</strong> things. It's like your code shouting out to the world:</p>

    <pre><code>puts "I'm alive!"</code></pre>

    <p>It stands for “put string,” but let’s be honest — it’s really “put sass.” You can use it to print anything inside quotes, and it shows up in your terminal.</p>

    <p>Ruby’s your sidekick now. Let’s hear it talk. 💬</p>
  CONCEPT

  task: <<~TASK,
    <p>Your Ruby code just woke up and it’s feeling <strong>dramatic</strong>.</p>

    <p>Print out this exact mini-monologue using <code>puts</code> (two lines, two puts):</p>

    <pre><code>I demand snacks!
And maybe… some games too?</code></pre>

    <p><em>Bonus points</em> for reading it aloud in a royal accent. 🎭</p>
  TASK
)
lesson_one.photo.attach(io: file, filename: "1.png", content_type: "image/png")
lesson_one.save!

puts "Creating Lesson 2 in Level 1"
file = File.open("app/assets/images/seed/Classes.png")
lesson_two = Lesson.create(name: "Classes", number: 2, concept: "In object-oriented programming, a class defines the shared aspects of objects created from the class. The capabilities of a class differ between programming languages, but generally the shared aspects consist of state (variables) and behavior (methods) that are each either associated with a particular object or with all objects of that class.", description: "In this lesson you'll learn everything about classes: what they are, how to write them and more.", task: "Create a class for animals", answer: "class Animal
  def speak
    puts 'Roar!''
  end
end", level: level_one)
lesson_two.photo.attach(io: file, filename: "Classes.png", content_type: "image/png")
lesson_two.save!

puts "Creating Lesson 3 in Level 1"
lesson_three = Lesson.create(name: "Conditional Logic", number: 3, concept: "Conditional logic, also known as conditional statements or conditionals, is a fundamental programming concept that allows a program to make decisions and execute different code blocks based on whether specific conditions are true or false. This enables programs to adapt to user input and varying situations, providing more complex and flexible functionality.", description: "In this lesson you'll learn everything about if statements: what they are, how to write them and more.", task: "Create an if for an voting age checker", answer: "if age > 18 puts you cant vote', answer: age = 16

if age >= 18
  puts 'You can vote!'
else
  puts 'Sorry, you're not old enough to vote.'
end", level: level_one)
file = File.open("app/assets/images/seed/Conditional_logic.png")
lesson_three.photo.attach(io: file, filename: "Conditional_logic.png", content_type: "image/png")
lesson_three.save!

puts "Creating Lesson 4 in Level 2"
lesson_four = Lesson.create(name: "Database Part 1", number: 4, concept: "Database programming involves using specific languages and techniques to interact with and manage databases, enabling them to store, retrieve, and manipulate data. It's crucial for various applications, from self-driving cars to package tracking systems.", description: "In this lesson you'll learn everything about db: what they are, how to write them and more.", task: "Create a db for a hospitals", answer: "rails g",  level: level_two)
file = File.open("app/assets/images/seed/db.png")
lesson_four.photo.attach(io: file, filename: "db.png", content_type: "image/png")
lesson_four.save!

puts "Creating Lesson 5 in Level 3"
lesson_five = Lesson.create(name: "Database Part 2", number: 5, concept: "Database programming involves using specific languages and techniques to interact with and manage databases, enabling them to store, retrieve, and manipulate data. It's crucial for various applications, from self-driving cars to package tracking systems.", description: "In this lesson you'll learn everything about db: what they are, how to write them and more.", task: "Create a db for a hospitals", answer: "rails g",  level: level_three)
file = File.open("app/assets/images/seed/db.png")
lesson_four.photo.attach(io: file, filename: "db.png", content_type: "image/png")
lesson_four.save!

puts "Creating Lesson 6 in Level 2 (Game)"
lesson_six = Lesson.create(name: "Build Dodge the Meteor!", number: 6, concept: "Collision detection + player movement. Let's combine everything you've learnt to build a game where meteors fall from the sky and your spaceship needs to avoid collision, or else it's Game Over!", description: "The sky’s falling! In this mini-game, you’ll control a character that must dodge incoming meteors. You’ll combine keyboard controls with basic collision logic to keep the player alive as long as possible.", task: "Build a 2D game where the player moves left and right to dodge falling meteors.
Your game should:
	•	Let the player move smoothly with arrow keys
	•	Spawn meteors that fall from the top
	•	Detect when a meteor hits the player (and end the game)
	•	Keep score based on how long the player survives", answer: "require 'ruby2d'

set title: 'Avoid the Meteor!', width: 400, height: 300

# Settings
PLAYER_SPEED = 5
BOMB_SPEED = 2
GAME_DURATION = 30  # seconds

@game_over = false
@x_direction = 0
@start_time = Time.now

# Player
@player = Square.new(
  x: 180, y: 260, size: 30,
  color: 'blue'
)

# Bombs (start off screen at random x positions)
@bombs = Array.new(7) do
  Square.new(
    x: rand(0..370), y: rand(-300..-20), size: 20,
    color: 'red'
  )
end

# Timer text
@timer_text = Text.new('Time: 0', x: 10, y: 10, size: 18)
@message = nil

# Controls
on :key_down do |event|
  if event.key == 'left'
    @x_direction = -1
  elsif event.key == 'right'
    @x_direction = 1
  end
end

on :key_up do |event|
  if ['left', 'right'].include?(event.key)
    @x_direction = 0
  end
end

# Game loop
update do
  next if @game_over

  # Update timer
  elapsed = Time.now - @start_time
  @timer_text.text = 'Time: \#{elapsed.round}'

  if elapsed >= GAME_DURATION
    @message = Text.new('You Win!', x: 140, y: 140, size: 24)
    @game_over = true
  end

  /# Move player
  @player.x += @x_direction * PLAYER_SPEED
  @player.x = [[@player.x, 0].max, Window.width - @player.size].min

  /# Move bombs
  @bombs.each do |bomb|
    bomb.y += BOMB_SPEED

    /# Reset bomb if it goes off screen
    if bomb.y > Window.height
      bomb.y = rand(-200..-20)
      bomb.x = rand(0..380)
    end

    /# Collision check
    if bomb.y + bomb.size >= @player.y &&
       bomb.x + bomb.size >= @player.x &&
       bomb.x <= @player.x + @player.size

      @message = Text.new('Game Over!', x: 130, y: 140, size: 24)
      @game_over = true
    end
  end
end

show", level: level_three)
file = File.open("app/assets/images/game-5.gif")
lesson_five.photo.attach(io: file, filename: "game-5.gif", content_type: "image/gif")
lesson_five.save!

puts "Creating Lesson 7 in Level 4"
lesson_seven = Lesson.create(name: "Hashes", number: 7, concept: "Hashing in programming involves using a mathematical algorithm (a hash function) to convert data into a fixed-length value, often called a hash code or hash value. This process is used in various applications, including data storage and retrieval, security measures like password storage, and digital signatures.", description: "In this lesson you'll learn everything about hashes: what they are, how to write them and more.", task: "Create a hash for movies", answer: 'eaxmple = {"key"=> "value"}', level: level_four)
file = File.open("app/assets/images/seed/Hashes.png")
lesson_six.photo.attach(io: file, filename: "Hashes.png", content_type: "image/png")
lesson_six.save!


puts "Creating David's progress"
# Marks multiple levels as complete
[level_one, level_two].each do |level|
  UserLevel.create(completed: true, user: david, level: level)
end

# Marks multiple lessons as complete
[lesson_one, lesson_two, lesson_three, lesson_four, lesson_five].each do |lesson|
  UserLesson.create(completed: true, user: david, lesson: lesson)
end


puts "Creating Dave's achievements"
davids_achievement_level_1 = Achievement.create(user: david, name: "🥇")
davids_achievement_level_2 = Achievement.create(user: david, name: "🥈")


# Done!
puts "All done! Created #{User.count} users, #{Lesson.count} lessons, #{Level.count} levels, #{Achievement.count} achievements and #{UserLesson.count} progresses (user lessons)"
