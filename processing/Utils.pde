String formatTime(int milliseconds){
    int seconds = (milliseconds / 1000) % 60;
    int minutes = (milliseconds / 60000);
    return nf(minutes, 2) + ":" + nf(seconds, 2);
}
