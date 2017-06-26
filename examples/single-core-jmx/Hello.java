class Hello {
    public static void main( String[] args ) throws Exception {
        while( true ) {
            System.out.println( "Hello, World!" );
            Thread.currentThread().sleep( 5000 );
        }
    }
}
