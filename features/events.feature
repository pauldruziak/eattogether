# language: uk
Функціонал: Створення події
  Коли люди розраховується постійно один за одного
    То виникає бажання відслідковувати ці витрати
    І відслідковувати окремо для різної групи людей та подій
  Тоді користувач створюю подію
    Та запрошує людей приднатись до цієї події якщо така можливість є
      І тоді ці люди самі зможуть вносити свої трати
    Або створює "віртуальних" користувачів
      Щоб самостійно відслідковувати взаємні розрахунки
  Для того щоб знати хто буде платити наступного разу

  Передумова:
    Припустимо, що я увійшов у систему

  Сценарій: успішне створення події
    Коли я створю подію з вірними даними
    Тоді я зможу її побачити

  # @javascript
  # Сценарій: подія з "віртуальними" учасниками
  #   Припустимо, що я увійшов у систему
  #   Якщо під час створення події я вкажу лише імена учасників
  #   Тоді будуть створенні "віртуальні" учасники

  # Сценарій: запрошення до події
  #   Припустимо, що я увійшов у систему
  #   Якщо під час створення події я вкажу email учасників
  #   То кожному з них прийде лист із запрошенням приєднатись до подiї
