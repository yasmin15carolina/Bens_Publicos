class PDTimeTutorial {
  int? userId;
  Duration? total;
  Duration? tutorial;
  Duration? distribution;
  Duration? election;
  int sawTutorial = 1;
  int sawDistribution = 1;
  int sawElection = 1;

  setTutorial(Duration duration) {
    tutorial = duration;
  }

  sawTutorialCountUp() {
    sawTutorial++;
  }
}
