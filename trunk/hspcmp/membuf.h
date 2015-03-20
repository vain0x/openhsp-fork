
//
//	membuf.cpp structures
//
#ifndef __membuf_h
#define __membuf_h

//  growmem class

class CMemBuf {
public:
	CMemBuf();
	CMemBuf( int sz );
	virtual ~CMemBuf();
	void AddIndexBuffer();
	void AddIndexBuffer( int sz );

	char *GetBuffer( void );
	int GetBufferSize( void );
	int *GetIndexBuffer( void );
	void SetIndex( int idx, int val );
	int GetIndex( int idx );
	int GetIndexBufferSize( void );
	int SearchIndexValue( int val );

	void RegistIndex( int val );
	void Index();
	void Put( int data );
	void Put( short data );
	void Put( char data );
	void Put( unsigned char data );
	void Put( float data );
	void Put( double data );
	void PutStr( char const *data );
	void PutStrDQ( char const*data );
	void PutStrBlock( char const *data );
	void PutCR();
	void PutData( void const *data, int sz );
	void PutStrf( char const *format, ... );
	int PutFile( char const *fname );
	int SaveFile( char const *fname );
	char *GetFileName();
	int GetSize() { return cur; }
	void ReduceSize( int new_cur );
	char *PreparePtr( int sz );

private:
	virtual void InitMemBuf( int sz );
	virtual void InitIndexBuf( int sz );

	//		Data
	//
	int		limit_size;			// Separate size
	int		size;				// Main Buffer Size
	int		cur;				// Current Size
	char	*mem_buf;			// Main Buffer

	int		idxflag;			// index Mode Flag
	int		*idxbuf;			// Index Buffer
	int		idxmax;				// Index Buffer Max
	int		curidx;				// Current Index

	char	name[256];			// File Name
};


#endif
