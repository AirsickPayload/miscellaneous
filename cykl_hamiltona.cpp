#include <iostream>

using namespace std;
int n, *vindex, m;
bool **W;

bool promising(int i)
{
    int j;
    bool sw;

    if(i==n-1 && !W[vindex[n-1]][vindex[0]])
        sw = false;
    else if(i>0 && !W[vindex[i-1]][vindex[i]])
        sw = false;
    else
    {
        sw = true;
        j = 1;
        while(j<i && sw)
        {
            if(vindex[i] == vindex[j])
                sw = false;
            j++;
        }
    }
    return sw;
}

void hamilton(int i)
{
    int j;
    if(promising(i))
        if(i==n-1){cout << endl << "Cykl: "; for(int j=0;j<n;j++) cout << vindex[j] << " ";}
    else
    for(j=2; j<=n; j++){
            vindex[i+1] = j;
            hamilton(i+1);
    }
}


int main()
{
  cout << "Podaj liczbe wierzcholkow(n): ";
  cin >> n;
    vindex = new int[n];
    W = new bool*[n+1];
    for(int i=1; i<=n;i++)
        W[i]=new bool[n+1];

    cout << "Podaj macierz sasiedztwa grafu( 1 - istnieje krawedz, 0 - brak krawedzi): " << endl;

        for(int i=1;i<=n;i++)
        {
            for(int j=1;j<=n;j++)
            cin >> W[i][j];
        }

    vindex[0]=1;
    hamilton(0);

    delete[] vindex;
    for(int i=0; i<=n;i++)
        delete[] W[i];
    delete[] W;
}
