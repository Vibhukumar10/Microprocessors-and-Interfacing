#include<bits/stdc++.h>
using namespace std;

int maxProduct(vector<int> arr)
{
    int n=arr.size();

    int minVal=arr[0];
    int maxVal=arr[0];

    int maxProd=arr[0];

    for(int i=1;i<n;i++)
    {
        if(arr[i]<0)
            swap(maxVal,minVal);
        
        minVal=min(arr[i],minVal*arr[i]);
        maxVal=max(arr[i],maxVal*arr[i]);

        maxProd=max(maxProd,maxVal);
    }
    return maxProd;
}

int main()
{
    vector<int> a = {2,-1,9,-4,10,-3,2};
    cout<<maxProduct(a);
    return 0;
}