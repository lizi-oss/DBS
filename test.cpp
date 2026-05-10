#include<stdio.h>
int main() {
    int arr[10] = {};
    for (int i = 0;i < 10;i++) {
        scanf("%d", &arr[i]);
    }
    int h;
    scanf("%d", &h);
    int count = 0;
    for (int i = 0;i < 10;i++) {
        if (arr[i] <= h + 30) {
            count++;
        }
    }
    printf("%d", count);
    return 0;
}