//Library functions
//Should not rely on global mutable state

float bound(float lo, float x, float hi){
    return min(hi, max(lo, x));
}
