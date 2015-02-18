#include <iostream>
#include <math.h>
#include <cstdlib>
using namespace std;

class element
{
    public:
    double key;
    element *next;
};


void bucket_sort(int n, double A[], int m)
{
    int p;
    bool dalej;
    element **B,*x,*z;
    B = new element*[m];

    for(int i=0; i<m; i++) { B[i] = NULL;}
    for(int i=1; i<=n;i++)
    {
        x = new element;
        p = floor(m*A[i]);
        x->key=A[i];
        z = B[p];
        if(z==NULL) {B[p] = x; x->next = NULL;}
        else if(A[i]<(z->key)) {B[p] = x; x->next= z;}
        else {dalej=true;
              while((z->next!=NULL) && dalej)
              {
                  if(A[i]<z->next->key) { x->next = z->next; z->next = x; dalej = false;}
                  else {z=z->next; }
              }
              if(dalej) {z->next=x; x->next=NULL; }
        }
    }

    for(int i=0;i<m;i++)
    {
        z=B[i];
        while(z!=NULL){
        cout << z->key << " ";
        z = z->next;}
    }
delete[] x,z;
for(int i=0;i<m;i++) { delete[] B[i];}
}


int main()
{
    int n;
    double *A;
    cout << "Ile liczb?: ";
    cin >> n;
    A = new double[n+1];

    cout << "----PETLA WCZYTYWANIA----" << endl;
	cout << "--PAMIETAJ:PODAWAJ TYLKO LICZBY MNIEJSZE NIZ 1!-- "<< endl;
	cout << "--W NOTACJI 0(kropka)XXX---" << endl;
    for(int i=1; i<=n;i++) {cin >> A[i];}

    cout << endl << "Uporzadkowany ciag: ";
    bucket_sort(n,A,4);
    delete[] A;
    system("pause");
    return 0;
}
