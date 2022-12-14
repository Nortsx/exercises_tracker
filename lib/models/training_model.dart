//model for quantity estimated trainings
class TrainingModel {
  //number of completed exercises so far
  late int currentAmount;

  late int currentAmountForProgressBar;

  //goal to achieve on daily basis
  late int goalInQuantity;

  //type of sport activity
  late String type;

  TrainingModel() {
    currentAmountForProgressBar = 0;
    currentAmount = 0;
    goalInQuantity = 100;
  }

//get previously saved data from db to restore currentAmount and goal.
  void fetchFromDB() {}

//upload each addition of completed excercises alongside their time of completion(year, day, hours, minutes)
  void uploadToDB(int newAmount, DateTime dateTime) {}

//return number of completed exercises
  int getCurrentAmount() {
    return currentAmount;
  }

//set goal for each day
  void setGoal(int newGoal) {
    goalInQuantity = newGoal;
  }

//increase amount of completed exercises by adding amount of ones you've just done
  void increaseBy(int amount, DateTime dateTime) {
    if (currentAmountForProgressBar + amount > 100) {
      currentAmountForProgressBar = 100;
    } else {
      currentAmountForProgressBar += amount;
    }
    currentAmount += amount;
    uploadToDB(
        amount, dateTime); // upload typeOfSport, date and increased amount
  }

//every 24h reset amount of completed exercises
  void resetCurrentAmount() {
    currentAmount = 0;
  }
}
