using System;
using System.Windows;


namespace WPF_Tranning
{
    /// <summary>
    /// MainWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            this.DataContext = new MainView(); // 바인딩 설정 (없으면 바인딩 안먹힘)
            // GameStartViewModel 호출함

        }


    }
}
