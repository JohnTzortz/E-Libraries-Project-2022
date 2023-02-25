
/**
 *  This function calulates the distances between two points.
 * 
 * It heavy influenced by this site: https://www.geeksforgeeks.org/program-distance-two-points-earth/
 */
function distance(lat1, lon1, lat2, lon2){
    lat1 = lat1 * Math.PI / 180;
    lon1 = lon1 * Math.PI / 180;
    lat2 = lat2 * Math.PI / 180;
    lon2 = lon2 * Math.PI / 180;

    let dlat = lat2 - lat1;
    let dlon = lon2 - lon1;
    let a = Math.pow(Math.sin(dlat/2), 2) + Math.cos(lat1) * Math.cos(lat2) * Math.pow(Math.sin(dlon / 2),2);

    let c = 2 * Math.asin(Math.sqrt(a));

    let r = 6371; // radious of earth in k.m. use 3965 for miles

    let ret_value = c*r; //this can be returned

    return ret_value.toFixed(3); //rounded to 3 decimals




}