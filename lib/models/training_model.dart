//model for quantity estimated trainings
class TrainingModel {
  //number of completed exercises so far
  late int currentAmount;

  late int currentAmountForProgressBar;

  //goal to achieve on daily basis
  late int goalInQuantity;

  //type of sport activity
  String type = "Sit-ups";

  late int goalInMinutes;

  TrainingModel() {
    currentAmount = 0;
    goalInQuantity = 100;
    goalInMinutes = 10;
    //type = "";
  }

//get previously saved data from db to restore currentAmount and goal.
  void fetchFromDB() {}

//return number of completed exercises
  int getCurrentAmount() {
    return currentAmount;
  }

//set goal for each day
  void setGoal(int newGoal) {
    goalInQuantity = newGoal;
  }

//increase amount of completed exercises by adding amount of ones you've just done
  void increaseBy(int amount) {
    currentAmount += amount;
  }

  void setProgresses(int amount) {
    currentAmount = amount;
    if (amount < goalInQuantity) {
      currentAmountForProgressBar = amount;
    } else {
      currentAmountForProgressBar = goalInQuantity;
    }
  }
}
