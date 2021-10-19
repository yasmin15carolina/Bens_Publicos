class PGTimeRound {
  int? userId;
  int? round;
  Duration? dragToken;
  Duration? distribution;
  Duration? election;

  setDragToken(Duration duration) {
    dragToken = duration;
  }

  setDistribution(Duration duration) {
    distribution = duration;
  }

  setElection(Duration duration) {
    election = duration;
  }
}
