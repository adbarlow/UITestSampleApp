using Xamarin.UITest;

namespace UITestSampleApp.UITests
{
    static class AppInitializer
    {
		public static IApp StartApp(Platform platform)
        {
            switch (platform)
            {
                case Platform.Android:
					return ConfigureApp
						.Android
						.ApkFile(@"/../../../UITestSampleApp2/Src/UITestSampleApp.Droid/bin/Debug/*.apk")
						.StartApp();

                case Platform.iOS:
                    return ConfigureApp.iOS.StartApp();

                default:
                    throw new System.NotSupportedException();
            }
        }
    }
}

