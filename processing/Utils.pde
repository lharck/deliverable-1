float maxHeartRate = 220 - 24;
int[] zones = {60, 70, 80, 90, 100};

String formatTime(int milliseconds){
    int seconds = (milliseconds / 1000) % 60;
    int minutes = (milliseconds / 60000);
    return nf(minutes, 2) + ":" + nf(seconds, 2);
}
