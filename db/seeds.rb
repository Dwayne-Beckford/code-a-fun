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
david = User.create(email:"matvey@test.com", password: "123456", name: "Matvey", points: 500)

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
level_five = Level.create(number: 5, name: "Snake")
level_five.photo.attach(io: file, filename: "game-4.gif", content_type: "image/gif")
level_five.save!

puts "Creating Level 6"
file = File.open("app/assets/images/game-5.gif")
level_six = Level.create(number: 6, name: "Dodge the Meteor")
level_six.photo.attach(io: file, filename: "game-5.gif", content_type: "image/gif")
level_six.save!

puts "Creating Level 7"
file = File.open("app/assets/images/game-6.gif")
level_seven = Level.create(number: 7, name: "Mega Challenge")
level_seven.photo.attach(io: file, filename: "game-6.gif", content_type: "image/gif")
level_seven.save!

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
file = File.open("app/assets/images/seed/2.png")
lesson_two = Lesson.create(
  name: "Name That Thing",
  number: 2,
  level: level_one,
  description: "Variables = pet names for your code. Way easier than yelling at raw text.",
  concept: <<~CONCEPT,
    <p>Imagine your code is a magical pantry. Every item you store needs a label — otherwise, you’ll mix up your spaghetti and your glitter. ✨🍝</p>

    <p>That’s where <strong>variables</strong> come in. They’re nicknames for stuff. Here’s how you use one:</p>

    <pre><code>treasure = "Gold Coins"
puts treasure</code></pre>

    <p>Now every time you say <code>treasure</code>, Ruby knows you mean the shiny goods. 🪙</p>

    <p>You can name your variables pretty much anything (well, almost — don’t name them after your ex), and they make your code waaaay easier to read.</p>
  CONCEPT
  task: <<~TASK,
    <p>Your mission: Give your code a bestie.</p>

    <p>Create a variable called <code>sidekick</code> and assign it your name (or superhero name, if you're feeling bold). Then make Ruby say it with <code>puts</code>.</p>

    <p>Example:</p>

    <pre><code>sidekick = "Thunder Cat"
puts sidekick</code></pre>

    <p>Now press run and imagine your code flexing in a cape. 🦸</p>
  TASK
  )
lesson_two.photo.attach(io: file, filename: "2.png", content_type: "image/png")
lesson_two.save!

puts "Creating Lesson 3 in Level 1"
file = File.open("app/assets/images/seed/3.png")
lesson_three = Lesson.create(
  name: "Talk Like a Human",
  number: 3,
  level: level_one,
  description: "Make your code sound smooth by slipping variables into sentences.",
  concept: <<~CONCEPT,
    <p>Ever wanted your code to sound a bit more... human?</p>

    <p>That’s where <strong>interpolation</strong> comes in. It lets you drop variables directly into your strings, like magic.</p>

    <pre><code>name = "Bubbles"
puts "Hello, \#{name}!"</code></pre>

    <p>Notice those <code>\#{}</code> curly braces? They’re like tiny portals where Ruby sneaks in the value of your variable.</p>

    <p>This way, your code doesn’t just spit out raw data — it <em>talks</em> like it means it.</p>
  CONCEPT
  task: <<~TASK,
    <p>It’s time to personalize your message, like a talking robot that knows your name. 🤖</p>

    <p>1. Create a variable called <code>sidekick</code> and set it to your sidekick’s epic name (like "Captain Bananas").</p>
    <p>2. Use interpolation to say hello to them:</p>

    <pre><code>sidekick = "Captain Bananas"
puts "Salutations, \#{sidekick}! Ready for adventure?"</code></pre>

    <p>Let’s make code that charms like a butler but hits like a comic book. 🎩💥</p>
  TASK
  )
lesson_three.photo.attach(io: file, filename: "3.png", content_type: "image/png")
lesson_three.save!

puts "Creating Lesson 4 in Level 2"
file = File.open("app/assets/images/seed/4.png")
lesson_four = Lesson.create(
  name: "Shape Up!",
  number: 4,
  level: level_two,
  description: "Let’s draw your very first shape — because real coders don’t just print, they paint.",
  concept: <<~CONCEPT,
    <p>Up until now, your code has just talked. Let’s make it <strong>draw</strong>.</p>

    <p>Using the <code>ruby2d</code> gem, you can pop shapes onto the screen like a digital Picasso.</p>

    <p>Here’s how to draw a square:</p>

    <pre><code>require 'ruby2d'

Square.new(
  x: 100, y: 100,
  size: 50,
  color: 'purple'
)

show</code></pre>

    <p>Each shape is like a little character you position using <code>x</code> and <code>y</code>, size them, and give them a splash of color.</p>

    <p>Ruby2D is your visual playground — and this is your first swing. 🛝</p>
  CONCEPT
  task: <<~TASK,
    <p>Your code has joined an art class. Its first assignment?</p>

    <p>Draw a <strong>big red square</strong> and place it somewhere on the canvas (your screen!).</p>

    <p>Use these clues:</p>
    <ul>
      <li><code>x</code> and <code>y</code> control <em>where</em> it shows up</li>
      <li><code>size</code> makes it <em>big or small</em></li>
      <li><code>color</code> adds style. Use <code>'red'</code></li>
    </ul>

    <pre><code>require 'ruby2d'

# Your awesome square here

show</code></pre>

    <p>Bonus points if you imagine the square is judging your artistic skills silently. 🟥🧐</p>
  TASK
)
lesson_four.photo.attach(io: file, filename: "4.png", content_type: "image/png")
lesson_four.save!

puts "Creating Lesson 5 in Level 3"
file = File.open("app/assets/images/seed/5.png")
lesson_five = Lesson.create(
  name: "Talk to Me, Score!",
  number: 5,
  level: level_three,
  description: "Make your game shout out your greatness. Loud and proud.",
  concept: <<~CONCEPT,
    <p>What’s the point of racking up points if no one knows about it?</p>

    <p>With <code>Text.new</code>, you can display things like score, lives, or dramatic taunts <em>right on the screen</em>.</p>

    <pre><code>@score_text = Text.new("Score: 0", x: 10, y: 10, size: 18)</code></pre>

    <p>You can update the text at any time like this:</p>

    <pre><code>@score_text.text = "Score: \#{@score}"</code></pre>

    <p>It’s like giving your game a little voice box. 🗣️ Time to brag every time you catch a coin!</p>
  CONCEPT
  task: <<~TASK,
    <p>Your game just learned how to talk — and it won’t shut up about your score. 🎯</p>

    <p>Create a <code>Text</code> object to display the player’s score in the top-left corner. Then, every time they earn a point, update it.</p>

    <p>Bonus idea: change the font size if the score hits 10. Because <strong>big score = big drama</strong>. 😎</p>
  TASK
  )
lesson_five.photo.attach(io: file, filename: "5.png", content_type: "image/png")
lesson_five.save!

puts "Creating Lesson 6 in Level 4"
file = File.open("app/assets/images/seed/6.png")
lesson_six = Lesson.create(
  name: "Chaotic Coin Drop",
  number: 6,
  level: level_four,
  description: "Unleash the randomness! Make those coins fall from wild places.",
  concept: <<~CONCEPT,
    <p>In games, <strong>randomness</strong> keeps things spicy. 🍕 Whether it’s falling coins or enemies popping out of nowhere, you don’t want your players getting too comfortable.</p>

    <p>Ruby’s <code>rand</code> method gives you random numbers:</p>

    <pre><code>rand(0..Window.width)</code></pre>

    <p>Perfect for spawning a coin at a random <code>x</code> coordinate:</p>

    <pre><code>coin.x = rand(0..(Window.width - coin.width))</code></pre>

    <p>Now no one knows where the riches will drop. Including you. 😈</p>
  CONCEPT
  task: <<~TASK,
    <p>Let’s rain coins like it’s payday at the arcade. 🎰</p>

    <p>Use <code>rand</code> to make each coin spawn at a random <code>x</code> position when it resets. Bonus: randomize the <code>y</code> too — just don’t make it fly off-screen.</p>

    <p>Your mission: keep it <strong>random</strong>, keep it <strong>fun</strong>, keep it <strong>catchable</strong>.</p>
  TASK
  )
lesson_six.photo.attach(io: file, filename: "6.png", content_type: "image/png")
lesson_six.save!

puts "Creating Lesson 7 in Level 5"
file = File.open("app/assets/images/seed/7.png")
lesson_seven = Lesson.create(
  name: "Snake Storage",
  number: 7,
  level: level_five,
  description: "Keep your snake parts in one stylish container: an array!",
  concept: <<~CONCEPT,
    <p>Snakes are long. And wiggly. And in coding terms… <strong>a list of parts</strong>.</p>

    <p>We need a way to store the entire snake’s body — every segment — in one place. That’s where <code>arrays</code> slither in.</p>

    <pre><code>snake = [{ x: 10, y: 10 }, { x: 9, y: 10 }, { x: 8, y: 10 }]</code></pre>

    <p>This array holds each part of the snake's glorious body. When it moves, we add a new head segment and remove the last one. Snake magic. 🪄</p>

    <p><code>unshift</code> puts a new piece at the front. <code>pop</code> removes the last piece. That’s your slithering sorted.</p>
  CONCEPT
  task: <<~TASK,
    <p>Your snake is feeling incomplete. It needs a proper body — not just a lonely square head. 😢</p>

    <p>Create an <code>array</code> to hold your snake’s body segments. Each segment should be a <code>hash</code> with <code>x</code> and <code>y</code> coordinates.</p>

    <p>Then try printing the snake array to the console to see how long it is. Just don’t let it get too full of itself. 🐍</p>
  TASK
  )
lesson_seven.photo.attach(io: file, filename: "7.png", content_type: "image/png")
lesson_seven.save!

puts "Creating Lesson 8 in Level 6"
file = File.open("app/assets/images/seed/8.png")
lesson_eight = Lesson.create(
  name: "Speeding Things Up",
  number: 8,
  level: level_six,
  description: "Make your game harder the longer you survive. Pressure = fun!",
  concept: <<~CONCEPT,
    <p>Ever notice how games start easy and suddenly your palms are sweating? That’s <strong>increasing difficulty</strong>.</p>

    <p>In our case, we’ll do it by making enemies move faster as time goes on. More speed = more chaos = more fun (and panic). 🎮</p>

    <p>You can create a variable like <code>enemy_speed</code> and increase it gradually inside your <code>update</code> loop or after hitting a score checkpoint:</p>

    <pre><code>enemy_speed += 0.1 if Time.now - @start_time > 10</code></pre>

    <p>Or make it dynamic with score:</p>

    <pre><code>enemy_speed = 2 + (@score * 0.1)</code></pre>

    <p>Start slow… but not for long. Let’s keep your player on their toes! 🏃‍♂️💨</p>
  CONCEPT
  task: <<~TASK,
    <p>Time to crank up the intensity like a cheesy action movie montage. 🧨</p>

    <p>Make your enemies speed up as your score increases. Start slow, but once the player proves they’ve got reflexes, dial it up. Maybe increase speed every 5 points?</p>

    <p><em>Optional:</em> Add a dramatic “you’ve got this” message when the chaos begins. Because encouragement matters.</p>
  TASK
  )
lesson_eight.photo.attach(io: file, filename: "8.png", content_type: "image/png")
lesson_eight.save!

puts "Creating Lesson 9 in Level 6 (Game)"
file = File.open("app/assets/images/game-5.gif")
lesson_nine = Lesson.create(
  name: "Build: Dodge the Meteor",
  number: 9,
  level: level_six,
  description: "Your final challenge in this level — dodge like your keyboard life depends on it!",
  concept: <<~CONCEPT,
    <p>This is it. The ultimate dodge fest. You’ve got everything you need: player movement, falling enemies, speed control, collision detection, score tracking — and nerves of steel.</p>

    <p>We're bringing it all together to build <strong>Dodge the Meteor</strong>, where your player (a humble spaceship or square, no judgment) dodges fiery meteors from above.</p>

    <p>Here’s what your game should have:</p>
    <ul>
      <li><strong>Player control</strong> with arrow keys</li>
      <li><strong>Enemies</strong> (meteors) falling from random positions</li>
      <li><strong>Speed increases</strong> over time or with score</li>
      <li><strong>Collision detection</strong> — one hit and it’s game over</li>
      <li><strong>Score display</strong> tracking how long you survived</li>
    </ul>

    <p>Bonus: Add stars in the background. Make it feel <em>spacey</em>.</p>
  CONCEPT
  task: <<~TASK,
    <p>🚀 Your mission, should you choose to accept it: build <strong>Dodge the Meteor</strong> — a game so thrilling, you’ll forget it’s teaching you code.</p>

    <p>Your game should:</p>
  <ul>
    <li>Let the player move smoothly using arrow keys</li>
    <li>Spawn meteors that fall from the top</li>
    <li>Detect when a meteor collides with the player (and end the game)</li>
    <li>Keep score based on how long the player survives</li>
  </ul>

  <p>May your reflexes be fast and your code even faster. 🧠🎮</p>
TASK
)
lesson_nine.photo.attach(io: file, filename: "game-5.gif", content_type: "image/gif")
lesson_nine.save!

puts "Creating Lesson 10 in Level 7"
file = File.open("app/assets/images/seed/10.png")
lesson_ten = Lesson.create(
  name: "Hash Me If You Can",
  number: 10,
  level: level_seven,
  description: "Store data like a boss with Ruby’s magical key-value vault.",
  concept: <<~CONCEPT,
    <p>Meet the <strong>Hash</strong> – Ruby’s version of a mini filing cabinet.</p>

    <p>It lets you pair up <strong>keys</strong> and <strong>values</strong> like this:</p>

    <pre><code>player = { name: "Zorg", score: 10 }</code></pre>

    <p>Now you can grab data by name instead of guessing positions like with arrays:</p>

    <pre><code>puts player[:name]  # => "Zorg"
puts player[:score] # => 10</code></pre>

    <p>Hashes make your code easier to read and waaay cooler to scale. 🧙‍♂️</p>
  CONCEPT
  task: <<~TASK,
    <p>Your space explorer has landed and we need their <strong>stats</strong>.</p>

    <p>Create a <code>player</code> hash that stores their:</p>
    <ul>
      <li><code>:name</code> — any heroic name of your choosing</li>
      <li><code>:planet</code> — where they're from (keep it mysterious)</li>
      <li><code>:fuel</code> — how much fuel they’ve got left (a number)</li>
    </ul>

    <p>Then print all three using <code>puts</code>. Time to show off your hash-fu! 💾</p>
  TASK
)
lesson_ten.photo.attach(io: file, filename: "10.png", content_type: "image/png")
lesson_ten.save!

puts "Creating David's progress"
# Marks multiple levels as complete
[level_one, level_two, level_three, level_four, level_five].each do |level|
  UserLevel.create(completed: true, user: david, level: level)
end

# Marks multiple lessons as complete
[lesson_one, lesson_two, lesson_three, lesson_four, lesson_five, lesson_six, lesson_seven, lesson_eight].each do |lesson|
  UserLesson.create(completed: true, user: david, lesson: lesson)
end


puts "Creating Dave's achievements"
davids_achievement_level_1 = Achievement.create(user: david, name: "🥇")
davids_achievement_level_2 = Achievement.create(user: david, name: "🥈")
davids_achievement_level_3 = Achievement.create(user: david, name: "🥉")
davids_achievement_level_4 = Achievement.create(user: david, name: "🎖️")
davids_achievement_level_5 = Achievement.create(user: david, name: "🏅")

# Done!
puts "All done! Created #{User.count} users, #{Lesson.count} lessons, #{Level.count} levels, #{Achievement.count} achievements and #{UserLesson.count} progresses (user lessons)"
