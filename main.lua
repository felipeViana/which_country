facts = {
  ['Brazil'] = {
    'Was ruled by the Portuguese for more than 300 years.',
    'It has the largest number of Japanese people outside of Japan.',
    'At least 180 languages are spoken in this country.',
    'Was the last country in the Americas to abolish slavery, in 1888.',
    'People from this country are very optimistic about their future and always believe that tomorrow will be a better day than today.',
    'Has a replica of the Statue of Liberty.',
    'The first South American country ever to host the Olympics.',
    'It has the world’s second-largest black population after Nigeria.',
    'It\'s the world’s second-largest producer of ethanol fuel.',
    'It has more than 4000 airports.'
  },
  ['Latvia'] = {
    'It contains more than 12,000 rivers. However, only 17 of these rivers are longer than 100 km.',
    'More than one third of this country land area is covered by forests.',
    'The Euro became the currency of this country in 2014.',
    'People from this country do not use gestures while communicating, or make minimal use of it.',
    'People from this country have a strong sense of space, and they generally like to stand a few feet away from the other person.',
    'Its national sport is ice hockey.',
    'It was ranked the world’s 32nd most peaceful country in the Global Peace Index of 2016.',
    'The country is home to a large variety of deciduous tree species including – oak, aspen, birch, black and white alder and others.',
    'It has one of the oldest flags in the world. The existence of its flag dates back to the 13th century.',
    'It has a total coastline of 498 km.'
  },
  ['Sudan'] = {
    'Its name translates to “the land of the blacks” in Arabic.',
    'The river Nile runs from the north to the south of this country.',
    'January first is the national day in this country.',
    'The metric system is the legal standard, but a highly diverse system based on Egyptian and British standards is in local use for weights and measures.',
    'Petroleum is the country\'s major natural resource.',
    'The country has significant deposits of chromium ore, copper, iron ore, mica, silver, gold, tungsten, and zinc.',
    'The first civil war occurred in the country during 1955-1972, and the second civil war happened during 1983-2005.',
    'It is the 16th largest country in the world by land area.',
    'This country has a total border length of 6,751 kilometers.',
    'In 2016, 26.4% of the population of this country uses the internet.'
  },
  ['Italy'] = {
    'It\'s flag is based on the French flag.',
    'Soccer fans from this country are called “tifosi”.',
    'Sons continue to live with their parents even in their thirties, usually until they marry. The family is a strong institution in the country.',
    'More than three-quarters of this country is either mountainous or hilly.',
    'It is the world’s largest producer of wine.',
    'Number 17 is considered unlucky in this country, which is also why some of the hotels do not have a 17th floor.',
    'It is considered unlucky to seat together 13 people at the dinner table.',
    'Breakfast in this country is a simple affair. If you want to eat like the locals, you’ll have to be satisfied with just a cappuccino and a croissant (such as brioche).',
    'Over 99% of the population can read and write.',
    '“Russo” is the most common surname in this country.'
  },
  ['Mexico'] = {
    'It was under Spanish rule for more than 3 centuries between the 1500s and 1821.',
    'As of 2015, indigenous people make up 21.5% of its population.',
    'It is the hardest working country in the world with an average citizen working 2,246 hours a year, or 43.2 hours a week.',
    'It has the largest taxi cab fleet in the world.',
    'Artists in the country can pay their taxes using artwork.',
    'It\'s the tenth most populated country in the world.',
    'By area, it is the fourteenth largest country in the world.',
    'It has 68 official languages.',
    'It uses four time zones.',
    'It hosted the FIFA Football World Cup twice; in 1970 and 1986.'
  }
}

countries = {
  'Brazil',
  'Latvia',
  'Sudan',
  'Italy',
  'Mexico'
}

local sceneManager = require 'src/sceneManager'

function love.load( ... )
  -- sceneManager.changeScene(require 'src/mainMenu')
  sceneManager.changeScene(require 'src/game')
end


function love.update(dt)
  sceneManager.currentScene.update(dt)
end

function love.draw()
  sceneManager.draw()
end

function love.keypressed(key)
  sceneManager.currentScene.keypressed(key)
end
